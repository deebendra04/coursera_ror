module Pagination
  class PaginationHelper
    def self.paginate(data, page: 1, per_page: 10)
      paginated_data = data.page(page).per(per_page)
      {
       current_page: paginated_data.current_page,
       next_page: paginated_data.next_page,
       prev_page: paginated_data.prev_page,
       total_pages: paginated_data.total_pages,
       total_count: paginated_data.total_count,
       results: paginated_data
       }
    end
  end
end
  