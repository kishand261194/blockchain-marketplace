class LineitemsController < ApplicationController
  before_action :authenticate_user!
  def index
    @lineitems = Lineitem.all
  end

  def new
    @lineitem = Lineitem.new
    redirect_to lineitems_path
  end

  def create
    @lineitem = Lineitem.new(lineitem_params)
    @lineitem.save
    if @lineitem.errors.messages.any?
      flash[:danger] = @lineitem.errors.messages[:base].join(', ')
      redirect_to lineitems_path
    else
      flash[:success] = "Successfully Added new Product"
      redirect_to lineitems_path
    end
  end

  private
    def lineitem_params
      params.require(:lineitem).permit(:quantity, :total, :product_id, :user_id )
    end
end
