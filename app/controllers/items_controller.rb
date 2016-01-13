class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]






  # GET /items
  # GET /items.json
  def index

   # @cat = params[:cat]
    @it = Item.where("category = ?", params[:cat])
    @distinct = Item.uniq.pluck(:category)
    @bank = Item.connection.select_value("SELECT sum(value) FROM items WHERE category = 'BANK FEES'")

    # @total = Item.connection.select_value("SELECT category, sum(value) as tot FROM items GROUP BY category")
    #@totals = Item.where("SELECT sum(category) as tot FROM items GROUP BY category")
   # @distinct = Item.uniq.pluck(:category)
    #@another = Item.where("SELECT category FROM items GROUP BY category")
    @cattotals = Item.group(:category).sum("value * gst * (100/multiplier)")




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

    @form = params[:form]

 end


  # POST /items
  # POST /items.json
  def create
    @distinct = Item.uniq.pluck(:category)
    @item = Item.new(item_params)
    @form = params[:form]

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

