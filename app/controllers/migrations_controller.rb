## Migrations Controller -- why needed?

class MigrationsController < ApplicationController
  before_action :set_migration, only: [:show, :edit, :update, :destroy]

  # GET /migrations
  # GET /migrations.json
  def index
    @migrations = Migration.all
  end

  # GET /migrations/1
  # GET /migrations/1.json
  def show
  end

  # GET /migrations/new
  def new
    @migration = Migration.new
  end

  # GET /migrations/1/edit
  def edit
  end

  # POST /migrations
  # POST /migrations.json
  def create
    @migration = Migration.new(migration_params)
    create_q(@migration)
  end

  # PATCH/PUT /migrations/1
  # PATCH/PUT /migrations/1.json
  def update
    update_q(@migration, migration_params)
  end

  # DELETE /migrations/1
  # DELETE /migrations/1.json
  def destroy
    destroy(@migration, migrations_url)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_migration
      @migration = Migration.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def migration_params
      params.require(:migration).permit(:notification, :person_id, :talk_id, :notification_type, :notification_text)
    end
end
