class CollectUserGoalService 
  attr_reader :experiences, :growths, :contributions
  def initialize(user)
    @user = user
    @experiences = []
    @growths = []
    @contributions = []
  end

  def collect_all
    @experiences = @user.goals.where(category: 'experience')
    @growths = @user.goals.where(category: 'growth')
    @contributions = @user.goals.where(category: 'contribution')
    return self
  end

  def collect(cat)
    @user.goals.where(category: cat)
  end
end