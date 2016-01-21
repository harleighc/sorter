class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def edit_category
     #@live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @array_of_live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name)
  end

  def update_list

  end

    def update_category

     old_items = Item.where(:category => params[:cat].strip).where(:item => params[:item].strip)
     updated_items = old_items.update_all(:category => params[:newcat].try(:strip))
     redirect_to root_path
  end


#   def update_category
#      puts "params: #{params.inspect}"
#      puts "params[:item]: #{params[:item].strip.inspect}"
#      puts "params[:cat]: #{params[:cat].strip.inspect}"
#      puts "params[:newcat]: #{params[:newcat].try(:strip).inspect}"
#      old_items = Item.where(:category => params[:cat].strip).where(:item => params[:item].strip)

#      puts "old items: #{old_items.inspect}"
#      updated_items = old_items.update_all(:category => params[:newcat].try(:strip))
#      puts "updated items: #{updated_items}"
#      redirect_to root_path
#   end


  def index

    @runningtotalgst = Item.sum('value * gst * multiplier')
    @runningtotal = Item.sum(:value)
    @live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name,:id,:user_id) if current_user

    #the following 3 variables are used to test that all items have been categorised
    @array_of_live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name)
    @total_of_live_categories = Item.where(:category => @array_of_live_categories).sum(:value)
    @total_from_db = Item.sum(:value) # needs an ID

    @cat = params[:cat]
    #@live_categories_total = Item.where("category = live_categories[:name]").sum(:value)
    #@distinct = Item.uniq.pluck(:category)
    @layout = params[:layout]
    @cattotals = Item.group(:category).sum('value * gst * multiplier')
    @itemised = Item.where("category = ?", params[:cat]).order(:value)
    @grouped = Item.where("category = ?", params[:cat]).group(:item).sum(:value)
    @grouped = @grouped.sort_by {|x,y|y}
    ##console @grouped  Item.where('category = "BANK FEES"').group(:item).sum(:value)
    @expandgrouptop = Item.where("category = ?", params[:cat]).where("item = ?", params[:item]).order(:value)
    # console @expandgrouptop Item.select('item, value').where('category = "BANK FEES"').where('item = "a"').order('value desc') -tested
    @expandgroupbottom = Item.select('item, sum(value)').where("category = ?", params[:cat]).where("item != ?", params[:item]).group(:item).sum(:value)
    @expandgroupbottom = @expandgroupbottom.sort_by {|x,y|y}
    #consonle @expandgroupbottom Item.select('item, sum(value) as val').where('category = "BANK FEES"').where('item != "a"').group(:item).sum(:value)



  end
  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/neww
  def new
    @item = Item.new
     @current_user = current_user.id

  end

  # GET /items/1/edit
  def edit
     @array_of_live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name)
   # @distinct = Item.uniq.pluck(:category)
    #@multi_update = Item.where('category == "INCOME"').update_all('multiplier == 50')
    @form = params[:form]
    @back_url =  session[:my_previous_url]



 end


  # POST /items
  # POST /items.json
  def create
    #@distinct = Item.uniq.pluck(:category)
    @item = Item.new(item_params)
     @current_user = current_user.id


    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    @distinct = Item.uniq.pluck(:category)


    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end

  end


  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def import
     Item.import(params[:file])
     redirect_to items_path, notice: "Companies Added Succesfully"
   end

  private
# Use callbacks to share common setup or constraints between actions.
  def set_item
  @item = Item.find(params[:id])
  end



    # Never trust parameters from the scary internet, only allow the white list through.
def item_params
     params.require(:item).permit(:item, :value, :category, :status, :gst, :multiplier, :date, :identifier, :newcat)
end



end

