class TasksController < ApplicationController
  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end

  def create
    @goal = Goal.find(params[:goal_id])
    @task = @goal.tasks.create(task_params)
    redirect_to goal_path(@goal), notice: "Task added successfully!"
  end

  private
    def task_params
      params.require(:task).permit(:item, :description, :goal)
    end
end
