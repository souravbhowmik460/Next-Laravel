<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CardController;

// Example default route (optional)
Route::get('/ping', function () {
    return response()->json(['message' => 'API is working!']);
});

// Auth routes
Route::post('/auth/register', [AuthController::class, 'register']);
Route::post('/auth/login', [AuthController::class, 'login']);
Route::post('/auth/forgot-password', [AuthController::class, 'forgotPassword']);
Route::post('/auth/change-password', [AuthController::class, 'changePassword'])
    ->middleware('auth:sanctum');

Route::get('/reset-password/{token}', function ($token) {
    return response()->json([
        'message' => 'Password reset placeholder',
        'token' => $token,
        'email' => request('email'),
    ]);
})->name('password.reset');


// Protected routes
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/cards', [CardController::class, 'store']);
    Route::get('/cards/{userId}', [CardController::class, 'index']);
    Route::put('/cards/{card}', [CardController::class, 'update']);
    Route::delete('/cards/{card}', [CardController::class, 'destroy']);
    Route::post('/auth/logout', [AuthController::class, 'logout']);
});
