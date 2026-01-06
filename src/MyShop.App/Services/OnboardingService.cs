using MyShop.Core.Interfaces.Services;
using MyShop.Core.Services;
using System.Collections.Generic;

namespace MyShop.App.Services
{
    public class OnboardingService : IOnboardingService
    {
        private const string FileName = "onboarding.json";
        private OnboardingData _data;

        public OnboardingService()
        {
            _data = LocalStorageHelper.Load<OnboardingData>(FileName) ?? new OnboardingData();
        }

        public bool IsOnboardingCompleted(string username)
            => _data.CompletedUsers.Contains(username);

        public void MarkOnboardingAsCompleted(string username)
        {
            if (!_data.CompletedUsers.Contains(username))
            {
                _data.CompletedUsers.Add(username);
                LocalStorageHelper.Save(FileName, _data);
            }
        }

        private class OnboardingData
        {
            public HashSet<string> CompletedUsers { get; set; } = new();
        }
    }
}
