import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const projects = defineCollection({
  loader: glob({ pattern: '**/*.md', base: './src/content/projects' }),
  schema: z.object({
    title: z.string(),
    order: z.number(),
    featured: z.boolean().default(true),
    tagline: z.string(),
    summary: z.string(),
    role: z.string(),
    collaborators: z.array(z.string()).default([]),
    methods: z.array(z.string()).default([]),
    repo: z.string().url().optional(),
    repoLabel: z.string().optional(),
    paper: z.string().optional(),
    liveDemo: z.string().url().optional(),
    liveCode: z.string().optional(),
    interactive: z.enum(['semicircle', 'stylometry', 'survival']).optional(),
    images: z
      .array(
        z.object({
          src: z.string(),
          alt: z.string(),
          caption: z.string().optional(),
          thumbnail: z.boolean().optional(), // marks the homepage card image
        }),
      )
      .default([]),
    animation: z
      .object({
        webm: z.string(),
        mp4: z.string(),
        poster: z.string(),
        alt: z.string(),
        caption: z.string().optional(),
        width: z.number().default(900),
        height: z.number().default(560),
      })
      .optional(),
  }),
});

export const collections = { projects };
