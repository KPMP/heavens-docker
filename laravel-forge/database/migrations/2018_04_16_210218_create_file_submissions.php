<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateFileSubmissions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('file_submissions', function (Blueprint $table) {
            $table->increments('id');
            $table->string('file_path');
            $table->string('file_name');
            $table->integer('case_id')
                ->unsigned();
            $table->integer('institution_id')
                ->unsigned();
            $table->integer('submitter_id')
                ->unsigned();
            $table->integer('file_meta_entry_id')
                ->unsigned();
            $table->integer('file_format_id')
                ->unsigned();
            $table->integer('device_vendor_id')
                ->unsigned();
            $table->integer('post_process_protocol_id')
                ->unsigned();
            $table->integer('magnification_level_id')
                ->unsigned();
            $table->integer('instrument_id')
                ->unsigned();
            $table->integer('viewer_id')
                ->unsigned();
            $table->integer('matrix_format_id')
                ->unsigned();
            $table->dateTime('file_created_at');
            $table->bigInteger('file_size');
            $table->boolean('is_open');
            $table->boolean('is_raw');
            $table->boolean('is_post_proccessing');
            $table->boolean('is_multiplane');
            $table->boolean('is_pyramid');
            $table->double('spatial_res', 8, 2);
            $table->bigInteger('channels');
            $table->bigInteger('bit_depth');
            $table->bigInteger('x_extent_pixels');
            $table->bigInteger('y_exttent_pixels');
            $table->bigInteger('z_plane_extent_layers');
            $table->softDeletes();
            $table->timestamps();
            $table->foreign('case_id')->references('id')->on('case_demographics');
            $table->foreign('institution_id')->references('id')->on('institution_demographics');
            $table->foreign('submitter_id')->references('id')->on('submitter_demographics');
            $table->foreign('file_meta_entry_id')->references('id')->on('file_meta_entries');
            $table->foreign('file_format_id')->references('id')->on('file_formats');
            $table->foreign('device_vendor_id')->references('id')->on('device_vendors');
            $table->foreign('post_process_protocol_id')->references('id')->on('post_process_protocols');
            $table->foreign('magnification_level_id')->references('id')->on('magnification_levels');
            $table->foreign('instrument_id')->references('id')->on('instruments');
            $table->foreign('viewer_id')->references('id')->on('viewers');
            $table->foreign('matrix_format_id')->references('id')->on('matrix_formats');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('file_submissions');
    }
}
