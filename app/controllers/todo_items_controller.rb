class TodoItemsController < ApplicationController

  def new
    @todo_item = TodoItem.new
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.create(params[:todo_item].permit(:content))
    if @todo_item.save
      flash[:success] = "Well done!"
      redirect_to @todo_list
    else
      flash[:error] = "Some error here!"
      render 'new'
    end

  end
end
