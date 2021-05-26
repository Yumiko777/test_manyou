class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = Label.all
  end

  def show
  end

  def new
    @label = Label.new
  end

  def edit
  end

  def create
    @label = Label.new(label_params)
    if params[:back]
      render :new
    else
      if @label.save
        redirect_to labels_path, notice: "ラベルを登録しました！"
      else
        render :new
      end
    end
  end

  def update
    if @label.update(label_params)
      redirect_to labels_path, notice: "ラベルを編集しました！"
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    redirect_to labels_path, notice: "ラベルを削除しました！"
  end

  private
  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end
