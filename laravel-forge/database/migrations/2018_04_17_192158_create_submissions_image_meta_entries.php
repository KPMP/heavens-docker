<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateSubmissionsImageMetaEntries extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('submissions_file_meta_entries', function (Blueprint $table) {
            $table->increments('id');
            $table->integer('submission_id')
                ->unsigned();
            $table->integer('file_meta_id')
                ->unsigned();
            $table->timestamps();
            $table->foreign('submission_id')->references('id')->on('file_submissions');
            $table->foreign('file_meta_id')->references('id')->on('file_meta_entries');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('submissions_file_meta_entries');
    }
}
