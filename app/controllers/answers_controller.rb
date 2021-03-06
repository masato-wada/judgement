class AnswersController < ApplicationController
  before_action :set_answer, only: [:show, :edit, :update, :destroy]

  # GET /answers
  # GET /answers.json
  def index
    @answers = Answer.all
  end

  # GET /answers/1
  # GET /answers/1.json
  def show
  end

  # GET /answers/new
  def new
    @answer = Answer.new
  end

  # GET /answers/1/edit
  def edit
  end

  # POST /answers
  # POST /answers.json
  def create
    # cookie設定
    set_cookie_answered_question

    @answer = Answer.new(answer_params)

    # 回答済みかを確認、回答済みの場合resultページへ遷移
    if @is_cookies.present? then
      redirect_to :controller => 'questions', :action => 'result', :id => params[:answer][:question_id], notice: NoticeMessages::HAVE_ALREADY_ANSWERED
    else
      respond_to do |format|
        if @answer.save
          if Rails.application.routes.recognize_path(request.referrer)[:controller] == 'questions' then
            format.html { redirect_to :controller => 'questions', :action => 'result', :id => params[:answer][:question_id], notice: 'Answer was successfully created.' }
            format.json { render :show, status: :created, location: @question }
          else
            format.html { redirect_to @answer, notice: 'Answer was successfully created.' }
            format.json { render :show, status: :created, location: @answer }
          end
        else
          format.html { render :new }
          format.json { render json: @answer.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /answers/1
  # PATCH/PUT /answers/1.json
  def update
    respond_to do |format|
      if @answer.update(answer_params)
        format.html { redirect_to @answer, notice: 'Answer was successfully updated.' }
        format.json { render :show, status: :ok, location: @answer }
      else
        format.html { render :edit }
        format.json { render json: @answer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /answers/1
  # DELETE /answers/1.json
  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to answers_url, notice: 'Answer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # 回答済みかを確認、回答済みの場合resultページへ遷移
    def set_cookie_answered_question
      if cookies[params[:answer][:question_id]].blank? then
        cookies[params[:answer][:question_id]] = true
      else
        @is_cookies = true
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_answer
      @answer = Answer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def answer_params
      if params[:answer][:comments_attributes]['0'][:comment].blank? then
        params.require(:answer).permit(:question_id, :select_id, :active_flg, :delete_flg)
      else
        params[:answer][:comments_attributes]['0'][:question_id] = params[:answer][:question_id]
        params[:answer][:comments_attributes]['0'][:select_id] = params[:answer][:select_id]
        params.require(:answer).permit(:question_id, :select_id, :active_flg, :delete_flg, comments_attributes: [:id, :question_id, :select_id, :comment])
      end
    end
end
