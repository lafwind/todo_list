class TodoListsController < ApplicationController
  def index
    @todo_lists = TodoList.all
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.create(todo_list_params)
    if @todo_list.save
      flash[:success] = "Well done!"
      redirect_to todo_lists_path
    else
      flash[:error] = "Some errors here!"
      render 'new'
    end
  end

    private

    def todo_list_params
      params[:todo_list].permit(:title, :description)
    end
end
