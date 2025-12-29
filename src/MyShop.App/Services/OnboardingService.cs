using MyShop.Core.Interfaces.Services;
using Windows.Storage;

namespace MyShop.App.Services
{
    public class OnboardingService : IOnboardingService
    {
        private const string OnboardingCompletedKey = "OnboardingCompleted";

        public bool IsOnboardingCompleted => 
            ApplicationData.Current.LocalSettings.Values.ContainsKey(OnboardingCompletedKey) && 
            (bool)ApplicationData.Current.LocalSettings.Values[OnboardingCompletedKey];

        public void MarkOnboardingAsCompleted()
        {
            ApplicationData.Current.LocalSettings.Values[OnboardingCompletedKey] = true;
        }
    }
}
