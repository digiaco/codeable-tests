jQuery(document).ready(function ($) {
    // $('.slider .wpb_wrapper').first().slick({
    //     infinite: true,
    //     arrows: false,
    //     dots: false,
    //     autoplay: false,
    //     speed: 800,
    //     slidesToShow: 1,
    //     slidesToScroll: 1,
    // });

    // let percentTime;
    // let tick;
    // let time = .1;
    // let progressBarIndex = 0;

    // $('.progressBarContainer .progressBar').each(function (index) {
    //     let progress = "<div class='inProgress inProgress" + index + "'></div>";
    //     $(this).html(progress);
    // });

    // function startProgressbar() {
    //     resetProgressbar();
    //     percentTime = 0;
    //     tick = setInterval(interval, 10);
    //     $('.progressBarContainer .item').removeClass('active');
    //     $('.progressBarContainer .item').eq(progressBarIndex).addClass('active');
    // }

    // function interval() {
    //     if (($('.slider .slick-track div[data-slick-index="' + progressBarIndex + '"]').attr("aria-hidden")) === "true") {
    //         progressBarIndex = $('.slider .slick-track div[aria-hidden="false"]').data("slickIndex");
    //         startProgressbar();
    //     } else {
    //         percentTime += 1 / (time + 5);
    //         $('.inProgress' + progressBarIndex).css({
    //             width: percentTime + "%"
    //         });
    //         if (percentTime >= 100) {
    //             $('.bd_slider .wpb_wrapper').first().slick('slickNext');
    //             progressBarIndex++;
    //             if (progressBarIndex > 2) {
    //                 progressBarIndex = 0;
    //             }
    //             startProgressbar();
    //         }
    //     }
    // }

    // function resetProgressbar() {
    //     $('.inProgress').css({
    //         width: 0 + '%'
    //     });
    //     clearInterval(tick);
    // }
    // startProgressbar();

    // $('.progressBarContainer .item').click(function () {
    //     clearInterval(tick);
    //     $('.progressBarContainer .item').removeClass('active');
    //     let goToThisIndex = $(this).addClass('active').find("span").data("slickIndex");
    //     $('.bd_slider .wpb_wrapper').first().slick('slickGoTo', goToThisIndex, false);
    //     startProgressbar();
    // });


    $('.slider').slick({
        infinite: true,
        arrows: false,
        dots: false,
        autoplay: false,
        speed: 800,
        slidesToShow: 1,
        slidesToScroll: 1,
    });

    let percentTime;
    let tick;
    let time = .1;
    let progressBarIndex = 0;

    $('.progressBarContainer .progressBar').each(function (index) {
        let progress = "<div class='inProgress inProgress" + index + "'></div>";
        $(this).html(progress);
    });

    function startProgressbar() {
        resetProgressbar();
        percentTime = 0;
        tick = setInterval(interval, 10);
        $('.progressBarContainer .item').removeClass('active');
        $('.progressBarContainer .item').eq(progressBarIndex).addClass('active');
    }

    function interval() {
        if (($('.slider .slick-track div[data-slick-index="' + progressBarIndex + '"]').attr("aria-hidden")) === "true") {
            progressBarIndex = $('.slider .slick-track div[aria-hidden="false"]').data("slickIndex");
            startProgressbar();
        } else {
            percentTime += 1 / (time + 5);
            $('.inProgress' + progressBarIndex).css({
                width: percentTime + "%"
            });
            if (percentTime >= 100) {
                $('.bd_slider').first().slick('slickNext');
                progressBarIndex++;
                if (progressBarIndex > 2) {
                    progressBarIndex = 0;
                }
                startProgressbar();
            }
        }
    }

    function resetProgressbar() {
        $('.inProgress').css({
            width: 0 + '%'
        });
        clearInterval(tick);
    }
    startProgressbar();

    $('.progressBarContainer .item').click(function () {
        clearInterval(tick);
        $('.progressBarContainer .item').removeClass('active');
        let goToThisIndex = $(this).addClass('active').find("span").data("slickIndex");
        $('.bd_slider').first().slick('slickGoTo', goToThisIndex, false);
        startProgressbar();
    });
});
