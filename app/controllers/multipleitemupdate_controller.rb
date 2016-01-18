class MultipleitemupdateController < ActionController::Base


  def new


   # @multiplecats = Item.where("category = ?", params[:cat]).where("item = ?", params[:item]).update_all(:item => params[:Newcats])
# console test Item.where('category = "INCOME"').where('item = "b"').update_all(:category = "BANK FEES")

    @newcat = params[:newcat]
    Item.where(:category => params[:cat]).where(:item => params[:item]).update_all('category = @newcat')

  end


end

private

def Multipleitemupdate_params
  params.require(:Multipleitemupdate).permit( :newcat)

end