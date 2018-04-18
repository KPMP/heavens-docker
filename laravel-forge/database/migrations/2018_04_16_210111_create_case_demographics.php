<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCaseDemographics extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('case_demographics', function (Blueprint $table) {
            $table->increments('id');
            $table->string('subject_id')
                ->nullable();
            $table->string('experiment_id')
                ->nullable();
            $table->dateTime('performed_at');
            $table->string('version_no');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('case_demographics');
    }
}
