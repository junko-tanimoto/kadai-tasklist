class TasksController < ApplicationController
    before_action :set_task, only: [:show, :edit, :update, :destroy]

    def index
        @tasks = Task.all.page(params[:page]).per(10)
    end

    def show
        #set_task
        #@tasks = Task.find(params[:id])before_action使用
    end
    
    def new
        @tasks = Task.new
    end
    
    def create
        @tasks = Task.new(task_params)
        
        if @tasks.save
            flash[:success] = 'タスクが正常に入力されました'
            redirect_to @tasks
        else
            flash.now[:danger] = 'タスクが正常に入力されませんでした'
            render :new
        end
    end
    
    def edit
        #set_task
        #@tasks = Task.find(params[:id]) before_action利用
    end
    
    def update
        #set_task
        #@tasks = Task.find(params[:id])
        
        if @tasks.update(task_params)
            flash[:success] = 'タスクは正常に更新されました'
            redirect_to @tasks
        else flash.now[:danger] = 'タスクは更新されませんでした'
            render :edit
        end
    end
    
    def destroy
        #set_task
        #@tasks = Task.find(params[:id]) before_action利用
        @tasks.destroy
        
        flash[:success] = 'タスクは正常に削除されました'
        redirect_to tasks_url
    end

  private 
  
    def set_task
        @tasks = Task.find(params[:id]) 
    end  
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
end
