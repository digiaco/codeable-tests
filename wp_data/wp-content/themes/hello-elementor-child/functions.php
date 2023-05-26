<?php

/* enqueue scripts and style from parent theme */
function hello_elementor()
{
    wp_enqueue_style('child-style', get_stylesheet_uri(), array());
    wp_enqueue_style('child-style-slick', '//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css', array());
    wp_enqueue_script('child-script-slick', '//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js', array('jquery'));
    wp_enqueue_script('child-script', get_theme_file_uri() . '/js/script.js', array('jquery'));
}
add_action('wp_enqueue_scripts', 'hello_elementor');

add_action('vc_after_init', 'add_slider_element');
function add_slider_element() {
    vc_map(array(
        'name' => 'Slider',
        'base' => 'slider_element',
        'description' => 'Slider element with images and text',
        'category' => 'Content',
        'params' => array(
            array(
                'type' => 'param_group',
                'param_name' => 'slides',
                'heading' => 'Slides',
                'value' => '',
                'params' => array(
                    array(
                        'type' => 'attach_image',
                        'heading' => 'Slide Image',
                        'param_name' => 'image',
                        'description' => 'Select an image for the slide',
                        'value' => '',
                    ),
                    array(
                        'type' => 'textarea',
                        'heading' => 'Slide Text',
                        'param_name' => 'content',
                        'description' => 'Enter text for the slide',
                        'value' => '',
                    ),
                    array(
                        'type' => 'textfield',
                        'heading' => 'Button link',
                        'param_name' => 'link',
                        'description' => 'Enter link for the slide',
                        'value' => '',
                    ),
                    array(
                        'type' => 'textfield',
                        'heading' => 'Progress Bar Title',
                        'param_name' => 'progressBar',
                        'description' => 'Enter title for the progress bar',
                        'value' => '',
                    ),
                ),
            ),
        ),
    ));
}

// Виведення елемента слайдера
add_shortcode('slider_element', 'render_slider_element');
function render_slider_element($atts, $content = null) {
    $atts = shortcode_atts(array(
        'slides' => '',
    ), $atts);

    $slides = vc_param_group_parse_atts($atts['slides']);

    ob_start(); ?>

    <div>
        <div class="slider bd_slider">
            <?php foreach ($slides as $slide) {
                $image_id = isset($slide['image']) ? $slide['image'] : '';
                $text = isset($slide['content']) ? $slide['content'] : '';
                $link = isset($slide['link']) ? $slide['link'] : '';
                
                if (empty($image_id)) {
                    continue;
                }
                
                $image_src = wp_get_attachment_image_src($image_id, 'full')[0]; ?>

                <div>
                    <div class="nSlide">
                        <div class="slide-text">
                            <?= $text; ?>
                            <a href="<?= $link; ?>" class="nSlide__btn">Start Now</a>
                        </div>
                        <img src="<?= $image_src; ?>" alt="Slide">
                    </div>
                </div>
            <?php } ?>
        </div>

        <div class="progressBarContainer">
            <?php foreach($slides as $key => $slide) : 
                $progressBar = isset($slide['progressBar']) ? $slide['progressBar'] : ''; ?>
                
                <div class="item <?= $key === 0 ? 'active' : '' ?>">
                    <span data-slick-index="<?= $key ?>" class="progressBar"></span>
                    <small>0<?= $key + 1 ?>.</small>
                    <h3><?= $progressBar ?></h3>
                </div>
                
            <?php endforeach; ?>
        </div>
    </div>


    <?php return ob_get_clean();
}
