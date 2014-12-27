class TodoItemsController < ApplicationController

  def new
    @todo_item = TodoItem.new
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.create(params[:todo_item].permit(:content))
    respond_to do |format|
      if @todo_item.save
        flash[:success] = "Well done!"
        format.html { redirect_to @todo_list }
        format.js
      else
        flash[:error] = "Some error here!"
        format.html { render 'new' }
        format.js
      end
    end
  end

  def update
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.update_attribute(:completed_at, Time.now)

    respond_to do |format|
      format.html { redirect_to @todo_list }
      format.js
    end
  end

  def destroy
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.find(params[:id])
    @todo_item.destroy
    redirect_to @todo_list
  end
end
