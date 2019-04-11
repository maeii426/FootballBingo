class TeamsController < ApplicationController
	before_action :set_team, only: [:show, :edit, :update, :destroy]

	def index
		@teams = Team.all
	end

	def show
	end

	def new
		@team = Team.new
	end

	def edit
	end

	def create
		@team = Team.new(team_params)
		respond_to do |format|
			if@team.save
				format.html { redirect_to @team, notice: 'Team was created successfully.' }
				format.json { render :show, status: :ok, location: @team }
			else
			end
		end
	end

	private
		def set_team
			@team = Team.find(params[:id])
		end

		def team_params
			params.require(:team).permit(:nameid, :name)
		end
	end