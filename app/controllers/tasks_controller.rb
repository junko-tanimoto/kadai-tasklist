class TasksController < ApplicationController
    #before_action :set_task, only: [:show, :destroy] #before_actionのcorrect_userで定義済み
    before_action :require_user_logged_in
    before_action :correct_user, only: [:edit, :update, :show,:destroy]

    def index
        #@task = current_user.tasks.build　#投稿の作成だから今回は不要
        @tasks = current_user.tasks.order(id: :desc).page(params[:page]).per(10)
        #@tasks = Task.all.page(params[:page]).per(10)
    end
    
    def show
        #set_task
        #@tasks = Task.find(params[:id]) #before_action使用
    end
    
    def new
        #@tasks = Task.new
        @task = current_user.tasks.new #一対多反映機能
    end
    
    def create
        #@tasks = Task.new(task_params)
        @task = current_user.tasks.new(task_params) #一対多反映機能
        
        if @task.save
            flash[:success] = 'タスクが正常に入力されました。'
            redirect_to @task
        else
            flash.now[:danger] = 'タスクが正常に入力されませんでした'
            render :new
        end
        
    end
    
    
    def edit
        #set_task
        @task = Task.find(params[:id])
    end
    
    def update
        #set_task
        @task = Task.find(params[:id])
        
        if @task.update(task_params)
            flash[:success] = 'タスクは正常に更新されました'
            redirect_to @task
        else flash.now[:danger] = 'タスクは更新されませんでした。'
            render :edit
        end
    end
    
    def destroy
        #set_task
        #@tasks = Task.find(params[:id]) before_action利用
        @tasks.destroy
        
        flash[:success] = 'タスクは正常に削除されました。'
        redirect_to tasks_url
    end

  private 
  
    #def set_task #correct_userメソッドで定義済みの為不要
        #@tasks = Task.find(params[:id]) 
    #end  
    
    def task_params
        params.require(:task).permit(:content, :status)
    end
    
    def correct_user
        @tasks = current_user.tasks.find_by(id: params[:id])
     unless @tasks
        redirect_to root_url
     end
    end
end
