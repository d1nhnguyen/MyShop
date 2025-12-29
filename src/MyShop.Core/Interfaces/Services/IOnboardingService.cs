namespace MyShop.Core.Interfaces.Services
{
    public interface IOnboardingService
    {
        bool IsOnboardingCompleted { get; }
        void MarkOnboardingAsCompleted();
    }
}
