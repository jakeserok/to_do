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

  def edit
    @goal = Goal.find(params[:id])
    @task = Task.find(params[:id])
  end

  def create
    @goal = Goal.find(params[:goal_id])
    @task = @goal.tasks.create(task_params)
    respond_to do |format|
      format.html { redirect_to goal_path(@goal), notice: 'Task added successfully!' }
      format.js
    end
  end

  def update
    @task = Task.find(params[:id])
    @goal = @task.goal_id
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to goal_path(@goal), notice: 'Task was successfully updated.' }
        # format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        # format.json { render json: @task.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  private

  def task_params
    params.require(:task).permit(:item, :description, :goal, :is_complete)
  end
end
