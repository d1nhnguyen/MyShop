using Microsoft.Extensions.DependencyInjection;
using Microsoft.UI.Xaml;
using MyShop.Core.Interfaces.Services;
using MyShop.Core.Interfaces.Repositories;
using MyShop.Core.Services;
using MyShop.Data.Repositories;
using MyShop.App.ViewModels;
using MyShop.App.Services;
using System;
using System.IO;
using LiveChartsCore;
using LiveChartsCore.SkiaSharpView;
using OfficeOpenXml;

namespace MyShop.App
{
    public partial class App : Application
    {
        private static readonly string _logPath = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData),
            "MyShop", "startup.log");

        public new static App Current => (App)Application.Current;
        public IServiceProvider Services { get; }
        public static Window MainWindowInstance { get; private set; }

        static App()
        {
            // Tạo thư mục log
            Directory.CreateDirectory(Path.GetDirectoryName(_logPath)!);
            Log("Static constructor starting...");
            
            try
            {
                OfficeOpenXml.ExcelPackage.LicenseContext = OfficeOpenXml.LicenseContext.NonCommercial;
                Log("EPPlus license set");
            }
            catch (Exception ex)
            {
                Log($"EPPlus license FAILED: {ex.Message}");
            }
        }

        public App()
        {
            Log("App() constructor starting...");
            
            try
            {
                Log("Calling InitializeComponent()...");
                this.InitializeComponent();
                Log("InitializeComponent() completed");
                
                this.UnhandledException += App_UnhandledException;
                Log("UnhandledException handler attached");

                Log("Configuring LiveCharts...");
                LiveChartsCore.LiveCharts.Configure(config =>
                    config.AddSkiaSharp()
                          .AddDefaultMappers()
                          .AddLightTheme());
                Log("LiveCharts configured");

                Log("Building DI container...");
                var services = new ServiceCollection();
                ConfigureServices(services);
                Services = services.BuildServiceProvider();
                Log("DI container built successfully");
            }
            catch (Exception ex)
            {
                Log($"App() constructor FAILED: {ex.Message}");
                Log($"Stack: {ex.StackTrace}");
                if (ex.InnerException != null)
                {
                    Log($"Inner: {ex.InnerException.Message}");
                    Log($"Inner Stack: {ex.InnerException.StackTrace}");
                }
                throw;
            }
        }

        public T GetService<T>() where T : class
        {
            return Services.GetRequiredService<T>();
        }

        private void App_UnhandledException(object sender, Microsoft.UI.Xaml.UnhandledExceptionEventArgs e)
        {
            Log($"UNHANDLED EXCEPTION: {e.Message}");
            Log($"Exception Type: {e.Exception?.GetType().FullName}");
            Log($"Stack Trace: {e.Exception?.StackTrace}");
            
            if (e.Exception?.InnerException != null)
            {
                Log($"Inner Exception: {e.Exception.InnerException.Message}");
                Log($"Inner Stack: {e.Exception.InnerException.StackTrace}");
            }
            
            System.Diagnostics.Debug.WriteLine($"Unhandled exception: {e.Message}");
            System.Diagnostics.Debug.WriteLine($"Stack Trace: {e.Exception?.StackTrace}");
            
            e.Handled = true;
        }

        private void ConfigureServices(IServiceCollection services)
        {
            Log("ConfigureServices() starting...");
            
            try
            {
                services.AddTransient<DashboardViewModel>();
                
                // Infrastructure
                Log("Registering ConfigService...");
                services.AddSingleton<IConfigService, ConfigService>();
                
                Log("Registering SessionManager...");
                services.AddSingleton<ISessionManager, SessionManager>();
                
                Log("Registering OnboardingService...");
                services.AddSingleton<IOnboardingService, OnboardingService>();

                // License Management Services
                Log("Registering License services...");
                services.AddSingleton<IFingerprintService, FingerprintService>();
                services.AddSingleton<ICryptoHelper, CryptoHelper>();
                services.AddSingleton<ISecureStorageService, SecureStorageService>();
                services.AddSingleton<ILicenseService, LicenseService>();

                Log("Creating GraphQLService...");
                var configService = new ConfigService();
                var graphQLService = new GraphQLService(configService.GetServerUrl());
                services.AddSingleton(graphQLService);
                services.AddSingleton<IGraphQLService>(graphQLService);
                Log("GraphQLService created");

                Log("Registering other services...");
                services.AddSingleton<IAuthService, AuthService>();
                services.AddSingleton<IAuthorizationService, AuthorizationService>();
                services.AddSingleton<IEncryptionService, EncryptionService>();
                services.AddSingleton<IDashboardService, DashboardService>();
                services.AddSingleton<IImageUploadService>(sp => new ImageUploadService("http://localhost:4000"));

                Log("Registering repositories...");
                services.AddSingleton<IUserRepository, GraphQLUserRepository>();
                services.AddSingleton<IProductRepository, GraphQLProductRepository>();
                services.AddSingleton<ICategoryRepository, GraphQLCategoryRepository>();
                services.AddSingleton<IReportRepository, GraphQLReportRepository>();
                services.AddSingleton<IOrderRepository, GraphQLOrderRepository>();
                services.AddSingleton<ICustomerRepository, GraphQLCustomerRepository>();
                services.AddSingleton<IDiscountRepository, GraphQLDiscountRepository>();

                services.AddSingleton<IProductImportService, ProductImportService>();
                services.AddSingleton<IDraftService, DraftService>();

                Log("Registering ViewModels...");
                services.AddTransient<MainWindow>();
                services.AddTransient<LoginViewModel>();
                services.AddTransient<ConfigViewModel>();
                services.AddTransient<ShellViewModel>();
                services.AddTransient<UsersViewModel>();
                services.AddTransient<ProductViewModel>();
                services.AddTransient<ProductDetailViewModel>();
                services.AddTransient<AddProductViewModel>();
                services.AddTransient<ImportProductsViewModel>();
                services.AddTransient<ReportsViewModel>();
                services.AddTransient<OrderViewModel>();
                services.AddTransient<CustomersViewModel>();
                services.AddTransient<DiscountsViewModel>();
                
                Log("ConfigureServices() completed");
            }
            catch (Exception ex)
            {
                Log($"ConfigureServices() FAILED: {ex.Message}");
                Log($"Stack: {ex.StackTrace}");
                throw;
            }
        }

        protected override void OnLaunched(Microsoft.UI.Xaml.LaunchActivatedEventArgs args)
        {
            Log("OnLaunched() starting...");
            
            try
            {
                Log("Getting MainWindow from DI...");
                m_window = Services.GetService<MainWindow>();
                MainWindowInstance = m_window;
                Log($"MainWindow retrieved: {m_window != null}");

                if (m_window != null)
                {
                    m_window.Closed += (s, e) =>
                    {
                        Log("Window closing...");
                        Application.Current.Exit();
                    };
                    
                    Log("Activating window...");
                    m_window.Activate();
                    Log("Window activated successfully");
                }
                else
                {
                    Log("ERROR: MainWindow is null!");
                }
            }
            catch (Exception ex)
            {
                Log($"OnLaunched() FAILED: {ex.Message}");
                Log($"Stack: {ex.StackTrace}");
                if (ex.InnerException != null)
                {
                    Log($"Inner: {ex.InnerException.Message}");
                    Log($"Inner Stack: {ex.InnerException.StackTrace}");
                }
                throw;
            }
        }

        private static void Log(string message)
        {
            try
            {
                File.AppendAllText(_logPath, $"{DateTime.Now:yyyy-MM-dd HH:mm:ss.fff}: {message}\n");
            }
            catch { }
        }

        private Window? m_window;
    }
}