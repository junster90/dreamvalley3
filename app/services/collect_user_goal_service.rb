class CollectUserGoalService 
  attr_reader :experience, :growth, :contribution
  def initialize(user)
    @user = user
    @experience = []
    @growth = []
    @contribution = []
  end

  def collect_all
    @experience = @user.goals.where(category: 'experience')
    @growth = @user.goals.where(category: 'growth')
    @contribution = @user.goals.where(category: 'contribution')
  end

  def collect(cat)
    @user.goals.where(category: cat)
  end
end