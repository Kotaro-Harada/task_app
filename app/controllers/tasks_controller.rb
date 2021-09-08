class TasksController < ApplicationController
  before_action :set_q, only: [:index, :search]
  
  def index
    @tasks = @q.result
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(params.require(:task).permit(:title,:start_day,:end_day,:all_day,:memo))
    if @task.save
      redirect_to tasks_path, notice: "スケジュールを登録しました"
    else
      render "new"
    end
  end

  def show
    @task = Task.find(params[:id])
    
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(params.require(:task).permit(:title,:start_day,:end_day,:all_day,:memo))
      flash[:notice] = "スケジュールを更新しました"
      redirect_to tasks_path
    else
      render "edit"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    flash[:alert] = "スケジュールを削除しました"
    redirect_to tasks_path
  end

  def search
    @results = @q.result
  end

  private

  def set_q
    @q = Task.ransack(params[:q])
  end
end

