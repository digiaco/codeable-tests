<?php

/**
 * Theme filters.
 */

namespace App;

/**
 * Add "… Continued" to the excerpt.
 *
 * @return string
 */
add_filter('excerpt_more', function () {
    return sprintf(' &hellip; <a href="%s">%s</a>', get_permalink(), __('Continued', 'sage'));
});


add_filter( 'body_class', function( $classes ) {
	return array_merge( $classes, array( 'leading-normal tracking-normal text-white gradient' ) );
} );