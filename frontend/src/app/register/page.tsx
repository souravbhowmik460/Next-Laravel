"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import api from "../../lib/api";
import { useForm } from "react-hook-form";
import toast, { Toaster } from "react-hot-toast";

type RegisterFormInputs = {
  firstName: string;
  lastName: string;
  email: string;
  password: string;
  password2: string;
};

export default function RegisterPage() {
  const router = useRouter();
  const [loading, setLoading] = useState(false);

  const {
    register,
    handleSubmit,
    watch,
    formState: { errors },
  } = useForm<RegisterFormInputs>();

  const onSubmit = async (data: RegisterFormInputs) => {
    if (data.password !== data.password2) {
      toast.error("Passwords do not match");
      return;
    }
    setLoading(true);
    try {
      const res = await api.post("/auth/register", {
        first_name: data.firstName,
        last_name: data.lastName,
        email: data.email,
        password: data.password,
        password_confirmation: data.password2,
      });
      const { token, id } = res.data.data;
      localStorage.setItem("token", token);
      localStorage.setItem("userId", id);
      toast.success("Registration successful!");
      router.push("/cards");
    } catch (err: any) {
      toast.error("Register failed: " + (err.response?.data?.message || "Unknown error"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-green-400 to-blue-500">
      <Toaster position="top-right" />
      <div className="bg-white rounded-2xl shadow-xl p-10 w-full max-w-md">
        <h1 className="text-3xl font-bold text-center text-gray-800 mb-6">Create Account</h1>
        <p className="text-center text-gray-500 mb-8">Fill in your details to register</p>

        <form onSubmit={handleSubmit(onSubmit)} className="space-y-5">
          <div className="flex gap-4">
            <div className="flex-1">
              <label className="block text-gray-700 mb-2">First Name</label>
              <input
                type="text"
                placeholder="First Name"
                className={`w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 ${
                  errors.firstName ? "border-red-500 focus:ring-red-400" : "focus:ring-green-400"
                }`}
                {...register("firstName", { required: "First name is required" })}
              />
              {errors.firstName && <p className="text-red-500 text-sm mt-1">{errors.firstName.message}</p>}
            </div>

            <div className="flex-1">
              <label className="block text-gray-700 mb-2">Last Name</label>
              <input
                type="text"
                placeholder="Last Name"
                className={`w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 ${
                  errors.lastName ? "border-red-500 focus:ring-red-400" : "focus:ring-green-400"
                }`}
                {...register("lastName", { required: "Last name is required" })}
              />
              {errors.lastName && <p className="text-red-500 text-sm mt-1">{errors.lastName.message}</p>}
            </div>
          </div>

          <div>
            <label className="block text-gray-700 mb-2">Email</label>
            <input
              type="email"
              placeholder="Enter your email"
              className={`w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 ${
                errors.email ? "border-red-500 focus:ring-red-400" : "focus:ring-green-400"
              }`}
              {...register("email", {
                required: "Email is required",
                pattern: { value: /^[^\s@]+@[^\s@]+\.[^\s@]+$/, message: "Invalid email address" },
              })}
            />
            {errors.email && <p className="text-red-500 text-sm mt-1">{errors.email.message}</p>}
          </div>

          <div>
            <label className="block text-gray-700 mb-2">Password</label>
            <input
              type="password"
              placeholder="Enter your password"
              className={`w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 ${
                errors.password ? "border-red-500 focus:ring-red-400" : "focus:ring-green-400"
              }`}
              {...register("password", {
                required: "Password is required",
                minLength: { value: 6, message: "Password must be at least 6 characters" },
              })}
            />
            {errors.password && <p className="text-red-500 text-sm mt-1">{errors.password.message}</p>}
          </div>

          <div>
            <label className="block text-gray-700 mb-2">Confirm Password</label>
            <input
              type="password"
              placeholder="Confirm your password"
              className={`w-full px-4 py-3 border rounded-lg focus:outline-none focus:ring-2 ${
                errors.password2 ? "border-red-500 focus:ring-red-400" : "focus:ring-green-400"
              }`}
              {...register("password2", {
                required: "Confirm your password",
                validate: (value) => value === watch("password") || "Passwords do not match",
              })}
            />
            {errors.password2 && <p className="text-red-500 text-sm mt-1">{errors.password2.message}</p>}
          </div>

          <button
            type="submit"
            disabled={loading}
            className={`w-full py-3 rounded-lg font-semibold text-white ${
              loading ? "bg-green-400 cursor-not-allowed" : "bg-green-500 hover:bg-green-400"
            } transition-colors`}
          >
            {loading ? "Registering..." : "Register"}
          </button>
        </form>

        <p className="text-center text-gray-500 mt-6">
          Already have an account?{" "}
          <a href="/login" className="text-green-500 font-semibold hover:underline">
            Login
          </a>
        </p>
      </div>
    </div>
  );
}
