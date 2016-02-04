class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :save_my_previous_url, only: [:index]




  def expand
  @expandgrouptop = Item.where("category = ?", params[:cat]).where("item = ?", params[:item]).order(:value)
  end


  def test
    @m = (params[:id].to_i)
    @mm = (params[:id].to_i) + 1
    @b = (params[:id].to_i) - 30
    @i = (params[:id].to_i)
    @t = (params[:id].to_i) + 30
    @contextbot = Item.where(:id => @b...@m )
    @contextmid = Item.where(:id => @i )
    @contexttop = Item.where(:id => @mm...@t )


  end

 def edit_gst
   @array_of_multipliers = [["100%",1],["95%", 0.95],["90%",0.9],["85%", 0.85],["80%",0.8],["75%", 0.75],["70%",0.7],["65%", 0.65],["60%",0.6],["55%", 0.55],["50%",0.5],["45%", 0.45],["40%",0.4],["35%", 0.35],["30%",0.3],["25%", 0.25],["20%",0.2],["15%", 0.15],["10%",0.1],["05%", 0.05],["00%",0.0]]

  end



  def edit_confirms
  end

  def edit_checks_mult
     #@live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @array_of_live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @array_of_multipliers = [["100%",1],["95%", 0.95],["90%",0.9],["85%", 0.85],["80%",0.8],["75%", 0.75],["70%",0.7],["65%", 0.65],["60%",0.6],["55%", 0.55],["50%",0.5],["45%", 0.45],["40%",0.4],["35%", 0.35],["30%",0.3],["25%", 0.25],["20%",0.2],["15%", 0.15],["10%",0.1],["05%", 0.05],["00%",0.0]]

  end

  def edit_checks_ind
     #@live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @array_of_live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @array_of_multipliers = [["100%",1],["95%", 0.95],["90%",0.9],["85%", 0.85],["80%",0.8],["75%", 0.75],["70%",0.7],["65%", 0.65],["60%",0.6],["55%", 0.55],["50%",0.5],["45%", 0.45],["40%",0.4],["35%", 0.35],["30%",0.3],["25%", 0.25],["20%",0.2],["15%", 0.15],["10%",0.1],["05%", 0.05],["00%",0.0]]

  end
  def edit_category
     #@live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @array_of_live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @array_of_multipliers = [["100%",1],["95%", 0.95],["90%",0.9],["85%", 0.85],["80%",0.8],["75%", 0.75],["70%",0.7],["65%", 0.65],["60%",0.6],["55%", 0.55],["50%",0.5],["45%", 0.45],["40%",0.4],["35%", 0.35],["30%",0.3],["25%", 0.25],["20%",0.2],["15%", 0.15],["10%",0.1],["05%", 0.05],["00%",0.0]]

  end

  def update_list

  end





  def update_gst
    old_items_gst = Item.where(:category => params[:cat])
    updated_items_gst = old_items_gst.update_all(:multiplier => params[:newmult])
    old_items_status = Item.where(:category => params[:cat])
    updated_items_gst = old_items_status.update_all(:status => params[:newstatus])
    redirect_to session[:my_previous_url]
  end

  def update_checks_ind
    old_items_checks_ind = Item.where(:category => params[:cat]).where(:id => params[:checks_ind].split(','))
    updated_items_checks_ind = old_items_checks_ind.update_all(:category => params[:newcat])
  end

  def update_checks_mult
       puts "PARAMS: #{params.inspect}"
       puts "params[:checks_mult]: #{params[:checks_mult].split(',').inspect}"
       old_items_checks_mult = Item.where(:category => params[:cat]).where(:item => params[:checks_mult].split(','))
       puts "old_items_checks_mult: #{old_items_checks_mult.inspect}"
       updated_items_checks_mult = old_items_checks_mult.update_all(:category => params[:newcat])
       puts "updated_items_checks_mult: #{updated_items_checks_mult.inspect}"
       redirect_to session[:my_previous_url]
  end

  def update_checks_ind
       puts "PARAMS: #{params.inspect}"
    puts "params[:checks_ind]: #{params[:checks_ind].split(',').inspect}"
    old_items_checks_ind = Item.where(:category => params[:cat]).where(:id => params[:checks_ind].split(','))
    puts "old_items_checks_ind: #{old_items_checks_ind.inspect}"
    updated_items_checks_ind = old_items_checks_ind.update_all(:category => params[:newcat])
    puts "updated_items_checks_ind: #{updated_items_checks_ind.inspect}"
       redirect_to session[:my_previous_url]
  end

  def update_category


     old_items_status = Item.where(:category => params[:cat].strip).where(:item => params[:item].strip)
     updated_items_status = old_items_status.update_all(:status => 0)
     old_items_mult = Item.where(:category => params[:cat].strip).where(:item => params[:item].strip)
     updated_items_mult = old_items_mult.update_all(:multiplier => params[:newmult].try(:strip))
     old_items_cat = Item.where(:category => params[:cat].strip).where(:item => params[:item].strip)
     updated_items_cat = old_items_cat.update_all(:category => params[:newcat].try(:strip))
     redirect_to session[:my_previous_url]
  end

    def update_confirms
     old_items = Item.where(:category => params[:cat].strip).where(:item => params[:item].strip)
     updated_items = old_items.update_all(:status => params[:newstatus].try(:strip))
     redirect_to session[:my_previous_url]
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


    #Item.where(:category => "unsorted").where(:item => "Yuzu Japanese").pluck(:id)
    @runningtotalgst = Item.sum('value * gst * multiplier')
    @runningtotal = Item.sum(:value)
    @live_categories_system = Categorytable.where(:user_id => 0).pluck(:name) if current_user
    @live_categories_user = Categorytable.where(:user_id => current_user.id).pluck(:name) if current_user
    @new_category_array = ["new","new","new","new","new","new"]
    #@live_categories_system = Categorytable.where(:user_id => 0).pluck(:name) if current_user
    #@live_categories_user = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name,:id,:user_id) if current_user
    #the following 3 variables are used to test that all items have been categorised
    @array_of_live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user
    @total_of_live_categories = Item.where(:category => @array_of_live_categories).sum(:value)
    @total_from_db = Item.sum(:value) # needs an ID
    @uniqcat = Item.pluck(:category).uniq

    @cat = params[:cat]
    #@live_categories_total = Item.where("category = live_categories[:name]").sum(:value)
    #@distinct = Item.uniq.pluck(:category)
    @layout = params[:layout]
    @cattotals = Item.group(:category).sum('value * gst * multiplier')
    @gsttotal = Item.sum('value * gst * multiplier')
    #@itemised = Item.where("category = ?", params[:cat]).order(:value)
    @itemised = Item.where("category = ?", params[:cat])


    #@grouped = Item.where("category = ?", params[:cat]).group(:item).sum(:value)
    @grouped = Item.where("category = ?", params[:cat]).group(:item).pluck('item,sum(value),max(status)')
    @grouped = @grouped.sort_by {|x,y,z|[-z,y,x]}
    ##console @grouped  Item.where('category = "BANK FEES"').group(:item).sum(:value)

    # console @expandgrouptop Item.select('item, value').where('category = "BANK FEES"').where('item = "a"').order('value desc') -tested
   # @expandgroupbottom = Item.select('item, sum(value),max(status)').where("category = ?", params[:cat]).where("item != ?", params[:item]).group(:item).sum(:value)
   # @expandgroupbottom = @expandgroupbottom.sort_by {|x,y,z|[z,y,x]}
    @expandgroupbottom = Item.where("category = ?", params[:cat]).where("item != ?", params[:item]).group(:item).pluck('item,sum(value),max(status)')
    @expandgroupbottom = @expandgroupbottom.sort_by {|x,y,z|[-z,y,x]}
    #consonle @expandgroupbottom Item.select('item, sum(value) as val').where('category = "BANK FEES"').where('item != "a"').group(:item).sum(:value)
      @it = Item.all
    respond_to do |format|
      format.html
      format.csv {render text: @it.to_csv}
    end
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
    @array_of_multipliers = [["100%",1],["95%", 0.95],["90%",0.9],["85%", 0.85],["80%",0.8],["75%", 0.75],["70%",0.7],["65%", 0.65],["60%",0.6],["55%", 0.55],["50%",0.5],["45%", 0.45],["40%",0.4],["35%", 0.35],["30%",0.3],["25%", 0.25],["20%",0.2],["15%", 0.15],["10%",0.1],["5%", 0.05]]
   # @distinct = Item.uniq.pluck(:category)
    #@multi_update = Item.where('category == "INCOME"').update_all('multiplier == 50')
    @form = params[:form]






 end


  # POST /items
  # POST /items.json
  def create

    #@distinct = Item.uniq.pluck(:category)
    @item = Item.new(item_params)
     @current_user = current_user.id


    respond_to do |format|

      if @item.save
        format.html { redirect_to root_path, notice: 'Item was successfully created.' }
        format.json {render :show, status: :created, location: @item }

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
        format.html { redirect_to session[:my_previous_url], notice: 'Item was successfully updated.' }
        format.json {  render :show, status: :ok, location: @item }
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

    @current_user = current_user.id
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

def save_my_previous_url
    # session[:previous_url] is a Rails built-in variable to save last url.
    session[:my_previous_url] = request.original_url
  end


end

