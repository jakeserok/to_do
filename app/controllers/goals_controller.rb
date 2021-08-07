class GoalsController < ApplicationController
  before_action :set_goal, only: %i[show edit update destroy]

  # GET /goals or /goals.json
  def index
    @goals = current_user.goals
  end

  # GET /goals/1 or /goals/1.json
  def show
    @next_goal = nil
    @previous_goal = nil
    @goal_ids = Goal.all.ids
    @current_index = @goal_ids.index(@goal.id)
    if @goal.id < current_user.goals.last.id
      @next_goal_index = @current_index + 1
      @next_goal = @goal_ids[@next_goal_index]
    end
    if @goal.id > 1
      @previous_goal_index = @current_index - 1
      @previous_goal = @goal_ids[@previous_goal_index]
    end
  end

  # GET /goals/new
  def new
    @goal = Goal.new
  end

  # GET /goals/1/edit
  def edit; end

  # POST /goals or /goals.json
  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user

    respond_to do |format|
      if @goal.save
        format.html { redirect_to @goal, notice: 'Goal was successfully created.' }
        # format.json { render :show, status: :created, location: @goal }
      else
        format.html { render :new, status: :unprocessable_entity }
        # format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PATCH/PUT /goals/1 or /goals/1.json
  def update
    respond_to do |format|
      if @goal.update(goal_params)
        format.html { redirect_to @goal, notice: 'Goal was successfully updated.' }
        format.json { render :show, status: :ok, location: @goal }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @goal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goals/1 or /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to goals_url, notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_goal
    @goal = Goal.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def goal_params
    params.require(:goal).permit(:title, :user_id)
  end
end
