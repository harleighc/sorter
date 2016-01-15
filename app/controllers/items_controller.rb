class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def newcat
   ##@newcat = params[:New]
  end

  def index

    @cat = params[:cat]
    @it = Item.where("category = ?", params[:cat]).order(:value)

    @distinct = Item.uniq.pluck(:category)
    @layout = params[:size]
    @cattotals = Item.group(:category).sum("value * gst * multiplier")
    @combinedview = Item.where("category = ?", params[:cat]).group(:item).sum(:value)
    @combinedview = @combinedview.sort_by {|x,y|y}

    ##Item.where('category = BANK FEES"').group(:item).sum(:value)
    ##
    ##combined view console Item.where('category = "BANK FEES"').group(:item).sum(:value)
    #top is an array
    @top = Item.where("category = ?", params[:cat]).where("item = ?", params[:itex]).order(:value)
    # console test Item.select('item, value').where('category = "BANK FEES"').where('item = "a"').order('value desc') -tested
    #bottom in a hash
     @bottom = Item.select('item, sum(value)').where("category = ?", params[:cat]).where("item != ?", params[:itex]).group(:item).sum(:value)
    @bottom = @bottom.sort_by {|x,y|y}
    #Item.select('item, sum(value) as val').where('category = "BANK FEES"').where('item != "a"').order('val desc').group(:item).sum(:value)



  end
  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @distinct = Item.uniq.pluck(:category)
    #@multi_update = Item.where('category == "INCOME"').update_all('multiplier == 50')
    @form = params[:form]
 end


  # POST /items
  # POST /items.json
  def create
    @distinct = Item.uniq.pluck(:category)
    @item = Item.new(item_params)

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
      params.require(:item).permit(:item, :value, :category, :status, :gst, :multiplier, :date, :identifier)
    end



end

