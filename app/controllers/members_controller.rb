class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def search
    @members = Member.ransack(name_cont_or_id_number_cont: params[:q]).result(distinct: true)

    respond_to do |format|
      format.html {}
      format.json {
        @members = @members.limit(5)
      }
    end
  end

  def history
    set_tab :members
    set_tab :history
    @member = Member.find_by_id params[:id]
    if @member.blank?
      flash[:danger] = "Member ID not found."
      redirect_to(welcome_index_path)
      return
    end
  end

  def show
    set_tab :members
    set_tab :current
    @member = Member.find_by_id params[:id]
    if @member.blank?
      flash[:danger] = "Member ID not found."
      redirect_to(welcome_index_path)
      return
    end
  end

  # def search
  #   @member =  Member.find_by_id_number(params[:search])
  #   if @member.blank?
  #     flash[:danger] = "Member ID not found."
  #     redirect_to(welcome_index_path)
  #     return
  #   end

  #   render 'show'
  #   # @member = Member.find_by_id_number(params[:search])
  # end

  def undo_link
    view_context.link_to('undo', revert_version_path(@loan.versions.last), :method=> :post)
  end

  def items
    @member = Member.find_by_id params[:id]
    if @member.blank?
      flash[:danger] = "Member ID not found."
      redirect_to(welcome_index_path)
      return
    end
    @items = Item.available
  end

  def borrow
    @loan = Loan.new
    @loan.member = Member.find(params[:member_id])
    @loan.item = Item.find_by_inventory_tag(params[:inventory_tag].upcase)

    if @loan.save
      flash[:success] = "Item borrowed. #{undo_link}"
    else
      flash[:danger] = "ERROR<p>Item was not borrowed.</p>"
    end
    redirect_to @loan.member
    # @member = Member.find_by_id_number(params[:search])
  end

  def return
    @loan = Loan.find(params[:id])
    @loan.returned_at = Time.now

    if @loan.save
      flash[:success] = "Item returned. #{undo_link}"
    else
      flash[:danger] = "ERROR<p>Item was not returned.</p>"
    end
    redirect_to @loan.member

    # render members_index
    # @member = Member.find_by_id_number(params[:search])
  end

  def new
    @member = Member.new
  end

  def edit
    @member = Member.find_by_id params[:id]
  end

  def create
    @member = Member.new(member_params)

    if @member.save
      redirect_to members_path
    else
      render 'new'
    end
  end

  def update
    @member = Member.find_by_id params[:id]

    if @member.update(member_params)
      redirect_to members_path
    else
      render 'edit'
    end
  end

  def destroy
    @member = Member.find_by_id params[:id]
    @member.destroy

    redirect_to members_path
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, :id_number, :group, :group_id)
  end
end
