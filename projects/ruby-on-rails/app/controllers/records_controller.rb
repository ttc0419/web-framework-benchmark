class RecordsController < ApplicationController
  def index
    @genres = Genre.all

    return if request.GET.empty?

    @records = Record.all.includes(:genre)

    if request.GET.key?('name') && request.GET['name'] != ''
      @records = @records.where('name LIKE ?', "%#{request.GET['name']}%")
    end

    if request.GET.key?('artist') && request.GET['artist'] != ''
      @records = @records.where('artist LIKE ?', "%#{request.GET['artist']}%")
    end

    if request.GET.key?('year') && request.GET['year'] != ''
      @records = @records.where('year <= ?', request.GET['year'])
    end

    if request.GET.key?('genre') && request.GET['genre'] != ''
      @records = @records.where(genre_id: request.GET['genre'])
    end
  end

  def destroy
    logger.info("Deleting record #{params[:id]}...")
    redirect_to(records_path)
  end
end
