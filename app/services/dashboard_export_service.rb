class DashboardExportService
    def initialize(user, format, options = {})
      @user = user
      @format = format
      @options = options
    end
  
    def perform
      case @format
      when :csv
        generate_csv
      when :xlsx
        generate_excel
      when :pdf
        generate_pdf
      end
    end
  
    private
  
    def generate_csv
      # CSV generation implementation
    end
  
    def generate_excel
      # Excel generation implementation
    end
  
    def generate_pdf
      # PDF generation implementation
    end
end