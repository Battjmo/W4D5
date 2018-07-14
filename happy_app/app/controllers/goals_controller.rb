class GoalsController < ApplicationController
  def new
    render :new
  end
  
  def create
    @goal = Goal.new(goal_params)
    
    if @goal.save
      redirect_to user_url(@goal.user_id)
    else
      flash[:errors] = @goal.errors.full_messages
      redirect_to new_goal_url
    end
  end
  
  def edit
    @goal = Goal.find_by(id: params[:id])
    render :edit
  end
  
  def patch
    @goal = Goal.find_by(id: params[:id])
    
    if @goal.update_attributes(goal_params)
      redirect_to user_url(@goal.user_id)
    else
      render :edit
    end
  end
  
  def destroy
    @goal = Goal.find_by(id: params[:id])
    @goal.destroy
    @goal
  end
  
  private
  def goal_params
    params.require(:goal).permit(:user_id, :description, :public, :completed)
  end
end