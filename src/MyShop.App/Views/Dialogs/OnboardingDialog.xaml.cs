using Microsoft.UI.Xaml;
using Microsoft.UI.Xaml.Controls;
using Microsoft.UI.Xaml.Shapes;

namespace MyShop.App.Views.Dialogs
{
    public sealed partial class OnboardingDialog : ContentDialog
    {
        public OnboardingDialog()
        {
            this.InitializeComponent();
        }

        private void OnboardingFlipView_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (OnboardingFlipView == null || Indicator1 == null) return;

            int index = OnboardingFlipView.SelectedIndex;
            
            // Update dots
            Indicator1.Opacity = index == 0 ? 1 : 0.3;
            Indicator2.Opacity = index == 1 ? 1 : 0.3;
            Indicator3.Opacity = index == 2 ? 1 : 0.3;
            Indicator4.Opacity = index == 3 ? 1 : 0.3;

            // Update primary button text
            if (index == OnboardingFlipView.Items.Count - 1)
            {
                PrimaryButtonText = "Get Started";
            }
            else
            {
                PrimaryButtonText = "Next";
            }
        }

        // Handle PrimaryButtonClick in the caller (ShellPage) to advance or close
    }
}
