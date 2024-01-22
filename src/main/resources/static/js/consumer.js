let replyUL = $(".card-body");
let replyPageFooter = $(".card-footer");

let param = '';
param = "nPage=" + nPage;
param += "&contentsno=" + contentsno;

showList();
showPage();

function showList() {
	getList({ contentsno: contentsno, sno: sno, eno: eno })
		.then(list => {
			let str = ""


			for (var i = 0; i < list.length; i++) {
				str += "<ul class='list-group'>";
				str += "<li class='list-group-item' data-rnum='" + list[i].rnum + "'>";
				str += "<strong class='float-start'>" + list[i].id + "</strong>";
				str += "<strong class='mx-5'>" + "★".repeat(list[i].star) + "</strong>";
				str += "<small class='float-end'>" + list[i].regdate + "</small><br><p>";
				str += replaceAll(list[i].content, '\n', '<br>') + "</p></li></ul>";
			}

			replyUL.html(str);
		});

}//showList() end

function replaceAll(str, searchStr, replaceStr) {
	return str.split(searchStr).join(replaceStr);
}


function showPage() {
	getPage(param)
		.then(paging => {
			let str = "<div><small class='text-muted'>" + paging + "</small></div>";

			replyPageFooter.html(str);
		});
}

let modal = $(".modal");
let modalInputContent = modal.find("textarea[name='content']");
let modalModBtn = $("#modalModBtn");
let modalRemoveBtn = $("#modalRemoveBtn");
let modalRegisterBtn = $("#modalRegisterBtn");


$("#addReplyBtn").on('click', function(e) {

    if(id == ''){
		alert('먼저 로그인을 하세요');
		let url = '/member/login';
		url += '?rurl=/contents/detail/'+contentsno;
		url += '&nPage='+nPage;
		alert(url);
		location.href = url;
		return;
	}
	modalInputContent.val("");

	modal.find("button[id !='modalCloseBtn']").hide();

	modalRegisterBtn.show();

	modal.modal("show");


});

modalRegisterBtn.on('click', function(e) {
	if (modalInputContent.val() == '') {
		alert("리뷰를 입력하세요:"+pname)
		modalInputContent.focus();
		return;
	}
	let modalSelectvalue = $("#star option:selected").val();
	console.log(modalSelectvalue);

	let reply = {
		content: modalInputContent.val(),
		id: id,
		contentsno: contentsno,
		star : modalSelectvalue,
		pname : pname
		
	};
	add(reply)
		.then(result => {
			modal.find("input").val("");
			modal.modal("hide");

			showList();
			showPage();

		}); //end add

}); //end modalRegisterBtn.on

//댓글 조회 클릭 이벤트 처리 

$(".chat").on("click", "li", function(e) {

	let rnum = $(this).data("rnum");

	get(rnum)
		.then(reply => {

			modalInputContent.val(reply.content);
			modal.data("rnum", reply.rnum);

			modal.find("button[id !='modalCloseBtn']").hide();
            if(id === reply.id){
				modalModBtn.show();
				modalRemoveBtn.show();
			}
			modal.modal("show");

		});
});

//댓글 수정
modalModBtn.on("click", function(e) {

	let reply = { 
		rnum: modal.data("rnum"), 
		content: modalInputContent.val(),
		pname : pname,
		star : $("#star option:selected").val()
		 };
	update(reply)
		.then(result => {
			modal.modal("hide");
			showList();
			showPage();
		});

});//modify

//댓글 삭제
modalRemoveBtn.on("click", function(e) {

	let rnum = modal.data("rnum");
	remove(rnum)
		.then(result => {
			modal.modal("hide");
			showList();
			showPage();
		});

});//remove
