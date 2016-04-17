class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.admin_membership(current_user)

    if @group.save
      UserMailer.new_group_email(current_user, @group).deliver_now
      create_group_invitations
      redirect_to @group
    else
      render :new
    end
  end

  def show
    @group = Group.find(params[:id])
    @admin_flag = @group.admin?(current_user)
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)

    if @group.save
      redirect_to(@group)
    else
      (render :edit)
    end
  end

  def edit
    @group = Group.find(params[:id])

    if @group.admin == current_user
      render :edit
    else
      flash[:notice] = "You are not allowed to edit this group"
      redirect_to @group
    end

    @admin_flag = @group.admin?(current_user)
  end

  private

  def group_params
    params.require(:group).permit(:name, :description, :exchange_date, :max_price)
  end
end
