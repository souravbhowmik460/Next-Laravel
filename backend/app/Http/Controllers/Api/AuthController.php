<?php
namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Password;
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

    public function forgotPassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
        ]);

        // Try sending reset link
        $status = \Illuminate\Support\Facades\Password::sendResetLink(
            $request->only('email')
        );

        if ($status === \Illuminate\Support\Facades\Password::RESET_LINK_SENT) {
            return response()->json([
                'success' => true,
                'message' => 'Password reset link sent to your email',
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => 'Unable to send reset link',
        ], 500);
    }

    /**
     * Change Password API
     * POST /api/auth/change-password
     */
    public function changePassword(Request $request)
    {
        $request->validate([
            'email' => 'required|email|exists:users,email',
            'old_password' => 'required|string',
            'new_password' => 'required|string|min:8|confirmed',
        ]);

        $user = auth()->user();

        if ($user->email !== $request->email) {
            return response()->json([
                'success' => false,
                'message' => 'Unauthorized user'
            ], 403);
        }

        if (!Hash::check($request->old_password, $user->password)) {
            return response()->json([
                'success' => false,
                'message' => 'Old password is incorrect'
            ], 400);
        }

        $user->password = Hash::make($request->new_password);
        $user->save();

        return response()->json([
            'success' => true,
            'message' => 'Password changed successfully'
        ]);
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
