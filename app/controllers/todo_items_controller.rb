class TodoItemsController < ApplicationController

  def new
    @todo_item = TodoItem.new
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    @todo_item = @todo_list.todo_items.create(params[:todo_item].permit(:content))
    @todo_items = @todo_list.todo_items.all
    respond_to do |format|
      if @todo_item.save
        flash[:success] = "Create new item successfully!"
        format.js
      else
        #format.html { render 'new' }
        flash[:success] = "Content cannot be blank!"
        format.js
      end
        # format.html { redirect_to @todo_list }
        format.html { render 'todo_lists/show', local: @todo_items }
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
