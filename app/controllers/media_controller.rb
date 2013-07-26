# 

class MediaController < ApplicationController

  def index
    @page = @nav = @header = 'Media'
  end

  def bylaws
    @page = "Chapter Bylaws"
    @header = "Alpha Zeta Eta Chapter Bylaws"
    @nav = 'Media'
  end
end