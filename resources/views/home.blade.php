@extends('layouts.app')

@section('content')
    <div class="container py-5">
        <div class="text-center">
            <h1 class="mb-3">HelpDesk IT</h1>
            <p class="text-muted mb-4">
                Sistem de ticketing pentru suport IT într-o organizație.
            </p>

            @guest
                <a href="{{ route('login') }}" class="btn btn-primary me-2">
                    Login
                </a>
                <a href="{{ route('register') }}" class="btn btn-outline-secondary">
                    Register
                </a>
            @endguest

            @auth
                <a href="{{ route('dashboard') }}" class="btn btn-success me-2">
                    Dashboard
                </a>
                <button class="btn btn-outline-secondary" disabled>
                    Creează ticket (în curând)
                </button>
            @endauth
        </div>
    </div>
@endsection
