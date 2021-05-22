class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    #@tasks = Task.all.order(created_at: :desc)
    if params[:sort_expired]
      @tasks = current_user.tasks
      @tasks = @tasks.order(deadline: :desc)
    else
      @tasks = current_user.tasks
      @tasks = @tasks.order(created_at: :desc)
    end

    if params[:sort_priority_high]
      @tasks = current_user.tasks
      @tasks = @tasks.order(priority: :asc)
    end
      #もし渡されたパラメータがタイトルとステータス両方だったとき
    if params[:name].present? && params[:status].present?
      @tasks = @tasks.search_name params[:name]
      @tasks = @tasks.search_status params[:status]
      #もし渡されたパラメータがタイトルのみだったとき
    elsif params[:name].present?
      @tasks = @tasks.search_name params[:name]
      #もし渡されたパラメータがステータスのみだったとき
    elsif params[:status].present?
      @tasks = @tasks.search_status params[:status]
    end

    @tasks = @tasks.page(params[:page]).per(5)
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: 'タスクを登録しました！'
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "タスクを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice:"タスクを削除しました！"
  end

  private
  def task_params
    params.require(:task).permit(:name, :detail, :deadline, :status, :priority)
  end

  def set_task
    @task = current_user.tasks.find(params[:id])
  end
end
