    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.UI.Xaml.Controls;
    using Microsoft.UI.Xaml.Media;
    using MyShop.App.ViewModels;
    using MyShop.Core.Interfaces.Services;
    using System;
    using System.ComponentModel;
    using System.Net.Http;
    using System.Runtime.CompilerServices;
    using System.Threading.Tasks;

    namespace MyShop.App.Views
    {
        public sealed partial class LoginScreen : Page, INotifyPropertyChanged
        {
            public LoginViewModel ViewModel { get; }

            private bool _isPasswordVisible;
            public bool IsPasswordVisible
            {
                get => _isPasswordVisible;
                set
                {
                    if (_isPasswordVisible != value)
                    {
                        _isPasswordVisible = value;
                        OnPropertyChanged();
                    }
                }
            }

            private string _statusText = "";
            public string StatusText
            {
                get => _statusText;
                set
                {
                    if (_statusText != value)
                    {
                        _statusText = value;
                        OnPropertyChanged();
                    }
                }
            }

            private Brush _statusColor = new SolidColorBrush(Microsoft.UI.Colors.Gray);
            public Brush StatusColor
            {
                get => _statusColor;
                set
                {
                    if (_statusColor != value)
                    {
                        _statusColor = value;
                        OnPropertyChanged();
                    }
                }
            }

            public event PropertyChangedEventHandler? PropertyChanged;

            private void OnPropertyChanged([CallerMemberName] string? propertyName = null)
            {
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
            }

            public LoginScreen()
            {
                this.InitializeComponent();
                
                // Get ViewModel from DI container
                ViewModel = App.Current.Services.GetRequiredService<LoginViewModel>();
                
                // Subscribe to events
                ViewModel.LoginSuccessful += OnLoginSuccessful;
                ViewModel.OpenConfigRequested += OnOpenConfigRequested;

                this.Unloaded += LoginScreen_Unloaded;
            }

            private void LoginScreen_Unloaded(object sender, Microsoft.UI.Xaml.RoutedEventArgs e)
            {
                ViewModel.LoginSuccessful -= OnLoginSuccessful;
                ViewModel.OpenConfigRequested -= OnOpenConfigRequested;
            }

            private void OnLoginSuccessful(object? sender, EventArgs e)
            {
                // Navigate to ShellPage on successful login
                Frame.Navigate(typeof(ShellPage));
            }

            private async void OnOpenConfigRequested(object? sender, EventArgs e)
            {
                var dialog = new ConfigScreen
                {
                    XamlRoot = this.XamlRoot
                };
                await dialog.ShowAsync();
            }

            private void RevealButton_Click(object sender, Microsoft.UI.Xaml.RoutedEventArgs e)
            {
                IsPasswordVisible = !IsPasswordVisible;
                
                // Update icon: E7B3 = RedEye (hidden), ED1A = Hide (visible)
                RevealIcon.Glyph = IsPasswordVisible ? "\uED1A" : "\uE7B3";
            }

            private async void Page_Loaded(object sender, Microsoft.UI.Xaml.RoutedEventArgs e)
            {
                // 1. Disable login button and show waiting message
                btnLogin.IsEnabled = false;
                StatusText = "⏳ Đang khởi động hệ thống...";
                StatusColor = new SolidColorBrush(Microsoft.UI.Colors.Orange);

                // 2. Start checking backend connection
                await WaitForBackend();
            }

            private async Task WaitForBackend()
            {
                var configService = App.Current.Services.GetRequiredService<IConfigService>();
                var serverUrl = configService.GetServerUrl();
                
                // Extract base URL from GraphQL endpoint (e.g., "http://localhost:4000/graphql" -> "http://localhost:4000/")
                var baseUrl = serverUrl.Replace("/graphql", "/");

                using (var client = new HttpClient())
                {
                    client.Timeout = TimeSpan.FromSeconds(1);

                    // Try to connect up to 10 times (10 seconds)
                    for (int i = 0; i < 10; i++)
                    {
                        try
                        {
                            // Try to ping the base URL
                            var response = await client.GetAsync(baseUrl);
                            
                            if (response.IsSuccessStatusCode || response.StatusCode == System.Net.HttpStatusCode.NotFound)
                            {
                                // ✅ CONNECTION SUCCESSFUL (even 404 means server is responding)
                                btnLogin.IsEnabled = true;
                                StatusText = "✅ Hệ thống sẵn sàng";
                                StatusColor = new SolidColorBrush(Microsoft.UI.Colors.Green);
                                return; // Exit method
                            }
                        }
                        catch
                        {
                            // Connection failed (backend not ready yet) -> Ignore and retry
                        }

                        // Wait 1 second before retrying
                        await Task.Delay(1000);
                    }

                    // If still not connected after 10 seconds
                    StatusText = "❌ Lỗi: Không thể kết nối Server!";
                    StatusColor = new SolidColorBrush(Microsoft.UI.Colors.Red);
                }
            }
        }
    }