<?php


use Livewire\Attributes\Layout;
use Livewire\Volt\Component;
use Illuminate\Validation\ValidationException;

new #[Layout('layouts.guest')] class extends Component
{
    public string $password = '';

    /**
     * Confirm the current user's password.
     */
    public function confirmPassword(): void
    {
        $this->validate([
            'password' => ['required', 'string'],
        ]);

        if (! Auth::guard('web')->validate([
            'email' => Auth::user()->email,
            'password' => $this->password,
        ])) {
            throw ValidationException::withMessages([
                'password' => __('auth.password'),
            ]);
        }

        session(['auth.password_confirmed_at' => time()]);

        $this->redirect(
            session('url.intended', "/dashboard"),
            navigate:true
        );
    }
}; ?>

<div class="max-w-sm mx-auto flex flex-col justify-center h-full">
    @section('title','Confirm Password')
    <div class="mb-2">
        <h1 class="text-3xl leading-10 font-bold">
            Enter Password.
        </h1>
        <div class="mt-3 text-neutral-600">
            This is a secure area of the application. Please confirm your password before continuing.
        </div>
    </div>
    <div class="mt-5 w-full">
        <x-error />
        <form wire:submit="confirmPassword">
            <!-- Password -->
            <div>
                <x-input-label for="password" :value="__('Password')" />
                <x-text-input wire:model="password" id="password"
                    class="block mt-1 w-full h-12 rounded-[5em] ps-5"
                    type="password"
                    name="password"
                    required autocomplete="current-password" />
            </div>

            <div class="mt-4">
                <x-g-button target="confirmPassword" content="Confirm" />
            </div>
        </form>
    </div>
</div>

