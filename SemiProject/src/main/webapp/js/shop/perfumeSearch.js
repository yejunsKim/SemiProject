let lenHIT = 8;
let start = 1;

$(function() {
    displaySearch(start);

    $(window).scroll(function() {
        if ($(window).scrollTop() + 10 >= $(document).height() - $(window).height()) {
            if ($('#countHIT').text() != $('#totalCount').val()) {
                start += lenHIT;
                displaySearch(start);
            }
        }
    });
});

function displaySearch(start) {
    const searchID = $('#searchIDVal').val();

    $.ajax({
        url: "/SemiProject/item/perfumeSearchJSON.do",
        method: "GET",
        data: {
            searchID: searchID,
            start: start,
            len: lenHIT
        },
        dataType: "json",
        success: function(json) {
            if (start === 1 && json.length === 0) {
                $('#displayHIT').html("<p>검색된 상품이 없습니다.</p>");
                return;
            }

            let html = "";
            $.each(json, function(_, item) {
                html += `<div class="col-md-6 col-lg-3">
                            <div class="card mb-3">
                                <a href="/SemiProject/item/itemDetail.do?itemno=${item.itemno}" class="itemDetail">
                                    <img src="/SemiProject${item.itemphotopath}" class="card-img-top" style="height: 350px; object-fit: cover;">
                                </a>
                                <div class="card-body">
                                    <h5 class="card-title">${item.itemname}</h5>
                                </div>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">${item.volume}ml</li>
                                    <li class="list-group-item d-flex justify-content-between">
                                        <a href="#" class="card-link">장바구니 담기</a>
                                        <span>${item.price.toLocaleString()}원</span>
                                    </li>
                                </ul>
                            </div>
                        </div>`;
            });

            $('#displayHIT').append(html);
            $('#countHIT').text(Number($('#countHIT').text()) + json.length);
            if ($('#countHIT').text() == $('#totalCount').val()) {
                $('#end').text("더 이상 조회할 제품이 없습니다.");
            }
        },
        error: function(err) {
            console.log("에러 발생:", err);
        }
    });
}
