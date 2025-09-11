<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $data = $request->validate([
            'first_name' => 'required|string|max:100',
            'last_name' => 'nullable|string|max:100',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|confirmed|min:8',
            'phone' => 'nullable|string',
        ]);

        $user = User::create([
            'name' => $data['first_name'].' '.($data['last_name'] ?? ''),
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
        ]);

        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json(['success' => true, 'message' => 'User registered', 'data' => [
            'id' => $user->id,
            'first_name' => $data['first_name'],
            'last_name' => $data['last_name'] ?? '',
            'email' => $user->email,
            'phone' => $data['phone'] ?? null,
            'token' => $token,
        ]], 201);
    }

    public function login(Request $request)
    {
        $data = $request->validate(['email'=>'required|email','password'=>'required|string']);

        if (!auth()->attempt($data)) {
            throw ValidationException::withMessages(['email' => ['Invalid credentials']]);
        }

        $user = auth()->user();
        $token = $user->createToken('api-token')->plainTextToken;

        return response()->json(['success' => true, 'message' => 'Login successful', 'data' => [
            'id' => $user->id,
            'first_name' => explode(' ', $user->name)[0] ?? '',
            'last_name' => explode(' ', $user->name)[1] ?? '',
            'email' => $user->email,
            'token' => $token,
        ]]);
    }

    public function logout(Request $request)
    {
        $request->user()->currentAccessToken()->delete();
        return response()->json(['success' => true, 'message' => 'Logged out']);
    }
}
