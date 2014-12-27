class TodoListsController < ApplicationController
  def index
    @todo_lists = TodoList.all
  end

  def show
    @todo_list = TodoList.find(params[:id])
    @todo_items = @todo_list.todo_items.all
  end

  def new
    @todo_list = TodoList.new
  end

  def create
    @todo_list = TodoList.create(todo_list_params)

    if @todo_list.save
    respond_to do |format|
      flash[:error] = "Create new todo list successfully!"
      format.html { redirect_to todo_lists_path }
      format.js
    end
    else
      render 'new'
    end
  end

  def edit
    @todo_list = TodoList.find(params[:id])
  end

  def update
    @todo_list = TodoList.find(params[:id])

    if @todo_list.update(todo_list_params)
      respond_to do |format|
        flash[:success] = "Update successfully!"
        format.html { redirect_to todo_lists_path }
        format.js
      end
    else
      render 'edit'
    end
  end

  def destroy
    @todo_list = TodoList.find(params[:id])
    @todo_list.destroy
    redirect_to todo_lists_path
  end

    private

    def todo_list_params
      #params[:todo_list].permit(:title, :description)
      params.require(:todo_list).permit(:title, :description)
    end
end
