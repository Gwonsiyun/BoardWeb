package boardWeb.util;

public class PagingUtil {

	private int nowPage; // 현재페이지
	private int startPage; //시작페이지
	private int endPage; //화면에서 끝 페이지번호
	private int total; //게시글 총갯수
	private int perPage; //화면당 글갯수
	private int lastPage; //최종페이지
	private int start; //쿼리에서 사용할 화면당 글 시작번호
	private int end; // 쿼리에서 사용할 화면당 글 종료번호
	private int cntPage=10; //화면에서 보여질 페이징 갯수
	
	public PagingUtil() {
		
	}
	
	public PagingUtil(int total,int nowPage, int perPage) {
		//현재페이지,게시글 갯수,화면당 게시글 갯수 초기화
		setNowPage(nowPage);
		setPerPage(perPage);
		setTotal(total);
		
		//전체의 최종 페이지번호 계산 lastpage 계산
		calcLastPage(total,perPage);
		
		//한 화면에서 보여질 시작 페이지와 종료 페이지 구하기
		calcStartEndPage(nowPage,cntPage);
		
		//쿼리에서 사용할 글 시작 번호와 종료 번호 구하기
		calcStartEnd(nowPage,perPage);
	}
	
	public void calcStartEnd(int nowPage,int perPage) {
		//한 화면의 게시글 종료 번호
		int end = nowPage*perPage;
		//한 화면의 게시글 시작 번호 
		int start = end-perPage+1;
		
		setEnd(end);
		setStart(start);
		
	}
	
	public void calcStartEndPage(int nowPage, int cntPage) {
		//한 화면에서 보여지는 마지막 페이지 계산
		int endPage = (((int)Math.ceil((double)nowPage/cntPage))*cntPage);
		
		// 최종 페이지가 endPage보다 작은 경우 endpage를 최종 페이지로
		// 최종 페이지는 ->23 일때 계산된 끝페이지는 30으로 계산 되므로
		// 끝 페이지를 최종 페이지로 변경
		if(getLastPage()<endPage) {
			setEndPage(getLastPage());
		}else {
			setEndPage(endPage);
		}
		
		//시작 페이지 계산하기
		int startPage = (endPage-cntPage+1);
		
		if(startPage<1) {
			startPage = 1;
		}
		setStartPage(startPage);
	}
	
	public void calcLastPage(int total,int perPage) {
		//(정수)소수점 올림(전체 게시글/한 페이지당 글갯수)
		int lastPage = (int)Math.ceil((double)total/perPage);
		setLastPage(lastPage);
		
	}

	public int getNowPage() {
		return nowPage;
	}

	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getPerPage() {
		return perPage;
	}

	public void setPerPage(int perPage) {
		this.perPage = perPage;
	}

	public int getLastPage() {
		return lastPage;
	}

	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}
}
