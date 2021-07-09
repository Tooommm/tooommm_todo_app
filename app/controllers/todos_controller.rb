class TodosController < ApplicationController
    before_action :logged_in_user

    def home
    end
  
    def index
      @user = current_user
      @todo  = current_user.todos.new
      @todos = current_user.todos
    end
  
    def create
      @todo = current_user.todos.build(todo_params)
      if @todo.save
        flash[:success] = "todo has been created!"
        redirect_to todos_path
      else
        render 'index'
      end
    end
  
    def update
      @todo = Todo.find(params[:id])
      if @todo.update(todo_params)
        flash[:success] = "todo updated"
      else
        flash[:alert] = "Error"
      end
      redirect_to todos_path
    end
  
    def destroy
      @todo = current_user.todos.find(params[:id])
      if @todo 
        @todo.destroy
        flash[:success] = "todo has been deleted"
      else
        flash[:alert] = "Error"
      end
      redirect_to todos_path
    end
  
    def show
      @todo = todo.find(params[:id])
    end
  
    private
  
    def todo_params
      params.require(:todo).permit(:title, :description, :due_date)
    end
end
