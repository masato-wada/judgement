class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :result, :edit, :update, :destroy]

  def index
    @questions = Question.where(delete_flg: 0)
  end

  def show
    check_delete_flg
    @selects = Select.where(question_id: params[:id], active_flg: 1, delete_flg: 0)
    @answer = Answer.new
  end

  def result
    check_delete_flg
    @selects = Select.where(question_id: params[:id], active_flg: 1, delete_flg: 0)
    @result = Hash::new
    @info_graph_num = Array::new
    @info_graph_desc = Array::new
    @info_graph_pie = Array::new
    @selects.each do |select|
      @result[select.id.to_i] = Answer.where(select_id: select.id, active_flg: 1, delete_flg: 0).count
      @info_graph_num.push(@result[select.id.to_i])
      @info_graph_desc.push(select.desc.to_s)
      _pie = Array::new
      _pie = {:name => select.desc.to_s, :y => @result[select.id.to_i]}
      @info_graph_pie.push(_pie)
    end

    @chart_pie = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({
        defaultSeriesType: 'pie',
        margin: [30, 10, 10, 10]
      })
      f.series({
        type: 'pie',
        name: GraphMessages::LABELS,
        tooltip: {
          pointFormat: '<b>{point.percentage:.1f}%</b>'
        },
        data: @info_graph_pie
      })
      f.options[:title][:text] = GraphMessages::LABELS
      f.legend(
        layout: 'horizontal',
        align: 'center',
        # verticalAlign: 'under'
      )
      f.plot_options(
        pie: {
          allowPointSelect: true,
          cursor: "pointer",
          showInLegend: true,
          dataLabels: {
            enabled: false,
            color: "black",
            style: {
              font: "13px Trebuchet MS, Verdana, sans-serif"
            }
          }
        }
      )
    end

    @chart_graph = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({:text => @question.title})
      f.options[:xAxis][:categories] = @info_graph_desc
      f.series(:type=> 'column', :name => GraphMessages::NUM, :data => @info_graph_num)
    end
  end

  def new
    @question = Question.new

    # 1questionで最大4select追加出来る
    # ☆☆☆最大は増やす予定☆☆☆
    4.times {
        @question.selects.build
    }
  end

  # GET /questions/1/edit
  def edit
    check_delete_flg
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    check_delete_flg
    respond_to do |format|
      if @question.update_attributes(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params[:question][:selects_attributes].each do |key,select|
        if action_name == 'create' && select[:desc] == '' && key.to_i >= 2 then
          params[:question][:selects_attributes].delete(key)
        end
      end
      params.require(:question).permit(:title, :desc, :limit_at, :delete_flg, selects_attributes: [:id, :desc])
    end

    def check_delete_flg
      if @question[:delete_flg] == 1 then
        redirect_to controller: 'errors', action: 'error_404'
      end
    end
end
