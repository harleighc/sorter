class CategorytablesController < ApplicationController
  before_action :set_categorytable, only: [:show, :edit, :update, :destroy]



  # GET /categorytables
  # GET /categorytables.json

  def edit_name
  end


  def index
    @categorytables = Categorytable.all
   # @distinct2 = Categorytable.uniq.pluck(:owner)
  end

  # GET /categorytables/1
  # GET /categorytables/1.json
  def show
  end

  # GET /categorytables/new
  def new
    @categorytable = Categorytable.new
    @live_categories = Categorytable.where(:user_id => [0,current_user.id]).pluck(:name) if current_user

  end

  # GET /categorytables/1/edit
  def edit
    @form = params[:form]


  end

  # POST /categorytables
  # POST /categorytables.json
  def create
    @categorytable = Categorytable.new(categorytable_params)




    respond_to do |format|
      if @categorytable.save
        format.html { redirect_to session[:my_previous_url], notice: 'Categorytable was successfully created.' }
        format.json { render :show, status: :created, location: @categorytable }
      else
        format.html { render :new }
        format.json { render json: @categorytable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categorytables/1
  # PATCH/PUT /categorytables/1.json
  def update
    respond_to do |format|
      if @categorytable.update(categorytable_params)
        format.html { redirect_to @categorytable, notice: 'Categorytable was successfully updated.' }
        format.json { render :show, status: :ok, location: @categorytable }
      else
        format.html { render :edit }
        format.json { render json: @categorytable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categorytables/1
  # DELETE /categorytables/1.json
  def destroy
    @categorytable.destroy
    respond_to do |format|
      format.html { redirect_to categorytables_url, notice: 'Categorytable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categorytable
      @categorytable = Categorytable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def categorytable_params
      params.require(:categorytable).permit(:name, :system, :owner, :user_id, :rank)
    end
end
