class TasksController < ApplicationController
    #before_action :set_task, only: [:show, :edit, :update, :destroy]
    before_action :require_user_logged_in
    before_action :correct_user, only: [:show, :edit, :update, :destroy]
    
    
    
    def index
        #@tasks = Task.where(status: 'done')
        
        
        if logged_in?
            @task = current_user.tasks.build  
            @tasks = current_user.tasks.order(id: :desc).page(params[:page]) #自分のだけ
        #@tasks = Task.all
       
        
        else
            redirect_to login_path
          #  @tasks = Task.all
        end
    end
    
    
    def show
        
    end

    def new
        @task = Task.new
    end
    
    def create
        
        @task = current_user.tasks.build(task_params)
        
    
        if @task.save
          flash[:success] = 'タスクを登録しました。'
          redirect_to root_url
        else
          #@task = current_user.tasks.order(id: :desc).page(params[:page])
          #flash.now[:danger] = 'タスクの登録に失敗しました。'
          #redirect_to root_url
          flash.now[:danger] = 'task の登録に失敗しました'
          render :new
        end
      
    end
    
    def edit 
       
    end    
    
    
    def update
        
        
        if @task.update(task_params)
           flash[:success] = 'task を更新しました'
           redirect_to @task
        else
            flash.now[:danger] = 'task の更新に失敗しました'
            render :edit
        end
        
    end
    
    def destroy
        
        @task.destroy
        #Task.find(params[:id]).destroy
        
        flash[:success] = 'task を削除しました。'
        redirect_to tasks_url
    end

    private
    
    #def set_task
    #    @task = Task.find(params[:id])
    #end

    def task_params
        params.require(:task).permit(:content, :status)
    end

    def correct_user
        @task = current_user.tasks.find_by(id: params[:id])
        unless @task
            redirect_to root_path
        end
    end
    
end
